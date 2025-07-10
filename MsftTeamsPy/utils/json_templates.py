def get_base_json_template():
    """Returns a base JSON template for Teams messages"""
    return {
        "@type": "MessageCard",
        "@Context": "http://schema.org/extensions",
        "Summary": None,
        "themeColor": None,
        "title": None,
        "text": None,
        "sections": [
            {
                "activitytitle": None,
                "activitysubtitle": None,
                "images": []
            },
            {
                "facts": None,
                "potentialAction": [
                    {
                        "name": None,
                        "@type": "OpenUri",
                        "targets": [
                            {
                                "os": "default",
                                "uri": None
                            }
                        ]
                    }
                ]
            }
        ]
    }

def get_button_json_templates():
    """Returns button JSON templates"""
    return {
        "TextInput": {
            "@type": "ActionCard",
            "Name": None,
            "Inputs": [
                {
                    "@type": "TextInput",
                    "id": "Comment",
                    "isMultiLine": True,
                    "title": "Enter Your Text Input Here"
                }
            ],
            "actions": [
                {
                    "@type": "HttpPOST",
                    "Name": "OK",
                    "target": None
                }
            ]
        },
        "DateInput": {
            "@type": "ActionCard",
            "Name": None,
            "Inputs": [
                {
                    "@type": "DateInput",
                    "id": "dueDate"
                }
            ],
            "actions": [
                {
                    "@type": "HttpPOST",
                    "Name": "OK",
                    "target": None
                }
            ]
        },
        "HttpPost": {
            "name": None,
            "@type": "HttpPOST",
            "Target": None
        },
        "OpenURI": {
            "name": None,
            "@type": "OpenURI",
            "Targets": [
                {
                    "os": "default",
                    "uri": None
                }
            ]
        }
    }

def get_image_json_template():
    """Returns image JSON template"""
    return {
        "image": None,
        "title": None
    }
