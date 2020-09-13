# Game in Action Images

In this chapter, you are going to allow games to upload pictures of a game. There are **many** moving parts for an image upload. You will find 90% of the code you need in the content below. The other 10% is for you to write.

## Game Model Property

Time to review your model for game images. It should look like the following model. You can name the class whatever you like. You can name the image field property whatever you like.

```py
class GamePicture:
    game = models.ForeignKey(Game, on_delete=models.DO_NOTHING, related_name='pictures')
    action_pic = models.ImageField(
        upload_to='actionimages', height_field=None,
        width_field=None, max_length=None, null=True)
```

## Media Settings

Make sure the following variables are set in your `settings.py` module.

```py
MEDIA_ROOT = 'media'
MEDIA_URL = '/media/'
```

THen in your `urls.py` module, make sure that the media settings are tied to a URL.

```py
urlpatterns = [
    # Your URLs here remain unchanged
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

## Game Details

When the gamer is viewing an individual game, there should be a button labeled "Upload Action Picture". When that button is clicked, the gamer should be presented with a form that has a file upload input field, and a button labeled "Upload".


```html
 <input type="file" id="game_image" />
 <input type="hidden" name="game_id" value={game.id} />
 <button onChange={(evt) => {
     createGameImageJSON(evt)
 }}>Upload</button>
```

When the game clicks the button, you need to convert the image file into a Base64 string.

```jsx
const getBase64 = (file, callback) => {
    const reader = new FileReader();
    reader.addEventListener('load', () => callback(reader.result));
    reader.readAsDataURL(file);
}

const createGameImageJSON = (event) => {
    getBase64(event.target.files[0], (base64ImageString) => {
        console.log("Base64 of file is", base64ImageString);

        /*
            Now that you have the image string, you can POST your
            image data to the API
        */
    });
}
```

Here's the JSON you need to send to the API.

```json
{
	"game_id": 1,
	"game_image": "base64 encoded string built in code above"
}
```

## Saving the Image

Import the `uuid` package so that you can generate a unique file name for the upload.

```py
import uuid
```

In the `create` method of your ViewSet, here is how you can save the file with a random file name.

```py
# Create a new instance of the game picture model you defined
# Example: game_picture = GamePicture()

format, imgstr = request.data["game_image"].split(';base64,')
ext = format.split('/')[-1]
data = ContentFile(base64.b64decode(imgstr), name=f'{request.data["game_id"]}-{uuid.uuid4()}.{ext}')

# Give the image property of your game picture instance a value
# For example, if you named your property `action_pic`, then
# you would specify the following code:
#
#       game_picture.action_pic = data

# Save the data to the database with the save() method
```