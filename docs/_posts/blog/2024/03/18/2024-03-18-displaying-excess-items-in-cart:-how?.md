---
layout: post
title: "Displaying Excess Items in Cart: How?"
date: "2024-03-18 20:02:36 +0600"
categories: blog
published: true
comments: true
tags: django
---

This post is based on the 8th chapter of an amazing book "Django 4 by example" written by [Antonio Melé](https://www.linkedin.com/in/amele/).

I am faced with such a problem: how can I display the quantity of an item in the shopping cart that is more than available for selection?

Let's say a user can add from 1 to 20 products from the product card. Also in the shopping cart, it can replace the current quantity with a new value from 1 to 20.

Imagine that a user has added 20 units of a certain product to the cart (*fig. A*).

![fig. A]({{ "/assets/blog/2024/03/18/image-1.png" | relative_url }})

What happens if a user wants to add another 20 units of the same product from its card?
It can be seen that the total amount is indicated correctly, but the quantity is not (*fig. B*)!

![fig. B]({{ "/assets/blog/2024/03/18/image-2.png" | relative_url }})

This can confuse the user.

To fix this, when initializing the form, you need to compare the current value with the maximum allowed value. If it is larger, then add it to the list of available values.

It was:

```python
# forms.py

PRODUCT_QUANTITY_CHOICES = [(i, str(i)) for i in range(1, 21)]


class CartAddProductForm(forms.Form):
    quantity = forms.TypedChoiceField(choices=PRODUCT_QUANTITY_CHOICES, coerce=int)
    override = forms.BooleanField(
        required=False, initial=False, widget=forms.HiddenInput
    )


# views.py

def cart_detail(request):
    cart = Cart(request)
    for item in cart:
        item["update_quantity_form"] = CartAddProductForm(
            initial={"quantity": item["quantity"], "override": True}
        )
    return render(request, "cart/detail.html", {"cart": cart})
```

It became:

```python
# forms.py

PRODUCT_QUANTITY_CHOICES = [(i, str(i)) for i in range(1, 21)]


class CartAddProductForm(forms.Form):
    quantity = forms.TypedChoiceField(choices=[], coerce=int)
    override = forms.BooleanField(
        required=False, initial=False, widget=forms.HiddenInput
    )

    def __init__(self, *args, **kwargs):
        max_quantity = kwargs.pop("max_quantity", 20)
        super(CartAddProductForm, self).__init__(*args, **kwargs)
        self.fields["quantity"].choices = PRODUCT_QUANTITY_CHOICES
        if max_quantity > 20:
            self.fields["quantity"].choices.append((max_quantity, str(max_quantity)))


# views.py

def cart_detail(request):
    cart = Cart(request)
    for item in cart:
        max_quantity = 20
        if item["quantity"] > 20:
            max_quantity = item["quantity"]
        item["update_quantity_form"] = CartAddProductForm(
            initial={"quantity": item["quantity"], "override": True},
            max_quantity=max_quantity,
        )
    return render(request, "cart/detail.html", {"cart": cart})
```

Now the user sees the correct value in the shopping cart (*fig. C*)!

![fig. C]({{ "/assets/blog/2024/03/18/image-3.png" | relative_url }})

Note that it can replace the quantity with the same values as before.
