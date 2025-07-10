def convert_from_dict(dictionary):
    """
    Converts a dictionary to a list of name-value pairs
    
    Args:
        dictionary (dict): Dictionary to convert
    
    Returns:
        list: List of dictionaries with name-value pairs
    """
    return [{"Name": key, "Value": value} for key, value in dictionary.items()]

def create_image_object(target_uri, title=None):
    """
    Creates an image object for Teams messages
    
    Args:
        target_uri (str): URI of the image
        title (str, optional): Title of the image
    
    Returns:
        dict: Image object
    """
    image_obj = {"image": target_uri}
    if title:
        image_obj["title"] = title
    return image_obj
