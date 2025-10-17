from django.db import models
from django.contrib.auth.models import User

from Helper.YoutubeIDParser import YoutubeIDParser





class Note(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notes')
    title = models.CharField(max_length=100)
    content = models.TextField()
    youtubeLink = models.TextField(default= "", blank = True,)
    youtubeid = models.CharField(max_length= 64,  blank=True, null=True, db_index=True )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
    
    def save(self, *args, **kwargs):
        try:
            self.youtubeid = YoutubeIDParser(self.youtubeLink) or None
        except Exception:
            self.youtubeid = None
        super().save(*args, **kwargs)