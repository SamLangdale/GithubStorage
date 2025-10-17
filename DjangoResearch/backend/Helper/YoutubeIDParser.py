
from urllib import parse


def YoutubeIDParser(link):
    parsed_link = parse.urlparse(link)
    #check if link is a standard url ex: https://www.youtube.com/watch?v=VIDEO_ID
    if(parsed_link.netloc == "www.youtube.com" and parsed_link.path == "/watch"):
        # the id is a query so we parse for the query and return the id
        video_id = parse.parse_qs(parsed_link.query).get("v")
        if video_id:
            return video_id[0]
    #check if link is a shortened url ex: https://youtu.be/VIDEO_ID
    elif(parsed_link.netloc == "youtu.be"):
        #we remove the / from the video path and get the id
        video_id = parsed_link.path.lstrip("/")
        return video_id
    
    else:
        # not in accepted or correct format
        return None


