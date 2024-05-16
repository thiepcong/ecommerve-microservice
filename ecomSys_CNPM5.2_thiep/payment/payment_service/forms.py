# forms.py

from paypal.standard.forms import PayPalPaymentsForm
from urllib.parse import urlencode

class CustomPayPalPaymentsForm(PayPalPaymentsForm):
    def get_paypal_url(self):
        base_url = "https://www.sandbox.paypal.com/cgi-bin/webscr"
        query = urlencode(self.initial)
        return f"{base_url}?{query}"
