import copy
from .utils import get_button_json_templates

class Button:
    """
    Creates a Button JSON object for use with Teams messages
    
    This class creates a Button JSON object that can be used with the TeamsMessage class.
    It supports different button types such as TextInput, DateInput, HttpPost, and OpenURI.
    """
    
    def __init__(self, button_type, button_name, target_uri):
        """
        Initialize a new Button
        
        Args:
            button_type (str): The type of button ('TextInput', 'DateInput', 'HttpPost', 'OpenURI')
            button_name (str): The text to appear on the button
            target_uri (str): The target URL that the button opens or attempts to POST a message
        
        Raises:
            ValueError: If button_type is not one of the valid types
        """
        if button_type not in ['TextInput', 'DateInput', 'HttpPost', 'OpenURI']:
            raise ValueError("Button type must be one of: 'TextInput', 'DateInput', 'HttpPost', 'OpenURI'")
        
        self.button_type = button_type
        self.button_name = button_name
        self.target_uri = target_uri
        self.button_templates = get_button_json_templates()
        
    def get_json(self):
        """
        Get the JSON representation of the button
        
        Returns:
            dict: JSON representation of the button
        """
        # Create a deep copy to avoid modifying the template
        button_json = copy.deepcopy(self.button_templates[self.button_type])
        
        # Set the button name
        button_json["Name" if self.button_type in ['TextInput', 'DateInput'] else "name"] = self.button_name
        
        # Set the target URI based on button type
        if self.button_type == 'OpenURI':
            button_json["Targets"][0]["uri"] = self.target_uri
        elif self.button_type == 'HttpPost':
            button_json["Target"] = self.target_uri
        else:
            button_json["actions"][0]["target"] = self.target_uri
            
        return button_json
