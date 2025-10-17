from urllib import parse

link = "https://www.youtube.com/watch?v=Zd0OoRdeqvE"
parsed_link = parse.urlparse(link)
print(parsed_link)
link2 = "https://youtu.be/Zd0OoRdeqvE?si=pm4IhkTlGXo_h-s1"
parsed_link2 = parse.urlparse(link2)
print(parsed_link2)

if(parsed_link.netloc == "www.youtube.com" and parsed_link.path == "/watch"):
    video_id = parse.parse_qs(parsed_link.query).get("v")
    if video_id:
        print(f"Video ID: {video_id[0]}")
    else:
        print("No video ID found in the URL.")

if(parsed_link2.netloc == "youtu.be"):
    video_id = parsed_link2.path.lstrip("/")
    print(f"Video ID: {video_id}")