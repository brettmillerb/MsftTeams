import json
import copy
import requests
from .utils import (
    COLOR_MAP,
    get_base_json_template,
    convert_from_dict,
    create_image_object
)

class TeamsMessage:
    """
    Creates and sends messages to Microsoft Teams channels via webhook
    
    This class allows you to create and send messages to Microsoft Teams channels
    using the Incoming Webhook connector.
    """
    
    def __init__(self, webhook_uri=None):
        """
        Initialize a new TeamsMessage
        
        Args:
            webhook_uri (str, optional): The URL from the Incoming Webhook
        """
        self.webhook_uri = webhook_uri or "https://outlook.office.com/webhook/GUID"
        self.json_data = get_base_json_template()
        
    def set_text(self, text):
        """
        Set the text of the message
        
        Args:
            text (str): Message text (supports Markdown)
            
        Returns:
            TeamsMessage: self for method chaining
        """
        self.json_data["text"] = text
        return self
        
    def set_title(self, title):
        """
        Set the title of the message
        
        Args:
            title (str): Title text
            
        Returns:
            TeamsMessage: self for method chaining
        """
        self.json_data["title"] = title
        return self
        
    def set_activity_title(self, activity_title):
        """
        Set the activity title of the message
        
        Args:
            activity_title (str): Activity title text
            
        Returns:
            TeamsMessage: self for method chaining
        """
        self.json_data["sections"][0]["activitytitle"] = activity_title
        return self
        
    def set_activity_subtitle(self, activity_subtitle):
        """
        Set the activity subtitle of the message
        
        Args:
            activity_subtitle (str): Activity subtitle text
            
        Returns:
            TeamsMessage: self for method chaining
        """
        self.json_data["sections"][0]["activitysubtitle"] = activity_subtitle
        return self
        
    def set_facts(self, facts):
        """
        Set facts as key-value pairs
        
        Args:
            facts (dict): Dictionary of facts
            
        Returns:
            TeamsMessage: self for method chaining
        """
        self.json_data["sections"][1]["facts"] = convert_from_dict(facts)
        return self
        
    def set_color(self, color):
        """
        Set the color of the message
        
        Args:
            color (str): Color name
            
        Returns:
            TeamsMessage: self for method chaining
            
        Raises:
            ValueError: If color is not a valid color name
        """
        if color not in COLOR_MAP:
            raise ValueError(f"Invalid color: {color}. Must be one of the predefined colors.")
        self.json_data["themeColor"] = COLOR_MAP[color]
        return self
        
    def add_button(self, button):
        """
        Add a button to the message
        
        Args:
            button (Button): Button object
            
        Returns:
            TeamsMessage: self for method chaining
        """
        if not self.json_data["sections"][1].get("potentialAction"):
            self.json_data["sections"][1]["potentialAction"] = []
        
        self.json_data["sections"][1]["potentialAction"].append(button.get_json())
        return self
        
    def add_image(self, image_url, title=None):
        """
        Add an image to the message
        
        Args:
            image_url (str): URL of the image
            title (str, optional): Title of the image
            
        Returns:
            TeamsMessage: self for method chaining
        """
        image_obj = create_image_object(image_url, title)
        self.json_data["sections"][0]["images"].append(image_obj)
        return self
    
    def get_json(self):
        """
        Get the JSON representation of the message
        
        Returns:
            str: JSON string
        """
        # Create a deep copy to avoid modifying the original
        json_data = copy.deepcopy(self.json_data)
        
        # Remove None values to clean up the JSON
        def remove_none(obj):
            if isinstance(obj, dict):
                return {k: remove_none(v) for k, v in obj.items() if v is not None}
            elif isinstance(obj, list):
                return [remove_none(item) for item in obj if item is not None]
            else:
                return obj
                
        cleaned_data = remove_none(json_data)
        return json.dumps(cleaned_data)
    
    def send(self, webhook_uri=None):
        """
        Send the message to the Teams webhook
        
        Args:
            webhook_uri (str, optional): Override the webhook URI
            
        Returns:
            requests.Response: Response from the webhook
            
        Raises:
            Exception: If the request fails
        """
        uri = webhook_uri or self.webhook_uri
        
        try:
            response = requests.post(
                uri,
                data=self.get_json(),
                headers={"Content-Type": "application/json"}
            )
            response.raise_for_status()
            return response
        except requests.exceptions.RequestException as e:
            raise Exception(f"Failed to send Teams message: {str(e)}")
