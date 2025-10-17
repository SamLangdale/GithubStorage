import React from "react";
import "../styles/Note.css"


function Note({ note, onDelete }) {
    const formattedDate = new Date(note.created_at).toLocaleDateString("en-US")

    return (
        <div className="note-container">
            <p className="note-title">{note.title}</p>
            <p className="note-content">{note.content}</p>
          {/*  <p className="note-youtubeLink">{note.youtubeLink}</p>
            <p className="note-YoutubeID">{note.youtubeid}</p>  */}  
            <div className="note-video"> 
            {note.youtubeid && (
                <iframe
                    width="560"
                    height="315"
                    src={`https://www.youtube.com/embed/${note.youtubeid}?start=0`}
                    title="YouTube video player"
                    frameBorder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    referrerPolicy="strict-origin-when-cross-origin"
                    allowFullScreen
                ></iframe>
            )}
            </div>
            <p className="note-date">{formattedDate}</p>
            <button className="delete-button" onClick={() => onDelete(note.id)}>
                Delete
            </button>
        </div>
    );
}

export default Note