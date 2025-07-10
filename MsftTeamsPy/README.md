# MsftTeamsPy

A Python library for creating and sending Microsoft Teams messages through webhooks.

## Installation

Before using the library, make sure to install the required dependencies:

```bash
pip install requests
```

## Usage

### Simple Message

```python
from MsftTeamsPy import TeamsMessage

# Create a new message
message = TeamsMessage("https://your-webhook-url-here")

# Set the text and send
message.set_text("This is a simple message").send()
```

### Detailed Message with All Features

```python
from MsftTeamsPy import TeamsMessage, Button

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
```

## API Reference

### TeamsMessage Class

The main class for creating and sending Teams messages.

#### Methods

- `__init__(webhook_uri=None)`: Initialize a new TeamsMessage.
- `set_text(text)`: Set the text of the message (supports Markdown).
- `set_title(title)`: Set the title of the message.
- `set_activity_title(activity_title)`: Set the activity title of the message.
- `set_activity_subtitle(activity_subtitle)`: Set the activity subtitle of the message.
- `set_facts(facts)`: Set facts as key-value pairs.
- `set_color(color)`: Set the color of the message.
- `add_button(button)`: Add a button to the message.
- `add_image(image_url, title=None)`: Add an image to the message.
- `get_json()`: Get the JSON representation of the message.
- `send(webhook_uri=None)`: Send the message to the Teams webhook.

### Button Class

Class for creating buttons of different types.

#### Methods

- `__init__(button_type, button_name, target_uri)`: Initialize a new Button.
- `get_json()`: Get the JSON representation of the button.

#### Button Types

- `TextInput`: A button that opens a text input dialog.
- `DateInput`: A button that opens a date picker dialog.
- `HttpPost`: A button that makes an HTTP POST request.
- `OpenURI`: A button that opens a link in a browser.

## License

See the LICENSE file in the project root for more information.
