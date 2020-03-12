extends Button

export(String) var scene_to_load


func button_toggled(toggled, target):
    print("which button = ", target.get_name())
    # I WISH I WOULD HAVE HERE THE THE BUTTON OBJECT OR AT LEAST THE 
    # NAME ON THE BUTTON.
    if toggled == true:
        print("Button is pressed")
    else:
        print("Button is released")