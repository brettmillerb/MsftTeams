from MsftTeamsPy import TeamsMessage, Button

def simple_message_example():
    """Example of a simple message"""
    # Create a new message
    message = TeamsMessage("https://your-webhook-url-here")
    
    # Set the text and send
    message.set_text("This is a simple message").send()

def detailed_message_example():
    """Example of a detailed message with all features"""
    # Create a new message
    message = TeamsMessage("https://your-webhook-url-here")
    
    # Build the message with chained methods
    message.set_title("Important Notification") \
           .set_text("This is a detailed message with **Markdown** support") \
           .set_activity_title("System Alert") \
           .set_activity_subtitle("High Priority") \
           .set_color("red") \
           .set_facts({
               "Status": "Critical",
               "Time": "15:30",
               "Server": "prod-web-01"
           }) \
           .add_image("https://example.com/alert-image.png") \
           .add_button(Button("OpenURI", "View Details", "https://example.com/details"))
    
    # Send the message
    response = message.send()
    print(f"Message sent with status code: {response.status_code}")

if __name__ == "__main__":
    # Run the examples
    simple_message_example()
    detailed_message_example()
