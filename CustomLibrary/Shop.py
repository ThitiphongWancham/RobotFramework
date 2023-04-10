from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class Shop:

    def __init__(self) -> None:
        self.selenium = BuiltIn().get_library_instance("SeleniumLibrary") 

    # Method name will be automatically converted to keyword in robot framework
    @keyword
    def hello_world(self):      # Keyword: Hello World
        print("Hello, World!")  

    @keyword
    def add_items_to_cart_and_checkout(self, products):   # Keyword: Add Items To Cart And Checkout
        web_elements = self.selenium.get_webelements("css:.card-title")
        index = 1
        for element in web_elements:
            if element.text in products:
                self.selenium.click_button(f"xpath:(//button[contains(text(),'Add')])[{index}]")
            index += 1
        self.selenium.scroll_element_into_view("css:a.btn-primary")
        self.selenium.click_link("css:a.btn-primary")