import Bool "mo:base/Bool";
import Int "mo:base/Int";
import Text "mo:base/Text";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {
    // Post type definition
    public type Post = {
        title: Text;
        body: Text;
        author: Text;
        timestamp: Int;
    };

    // Store posts in stable variable
    stable var posts : [Post] = [];

    // Add a new post
    public func createPost(title: Text, body: Text, author: Text) : async Bool {
        let newPost : Post = {
            title = title;
            body = body;
            author = author;
            timestamp = Time.now();
        };
        
        posts := Array.append<Post>([newPost], posts);
        return true;
    };

    // Get all posts sorted by timestamp (newest first)
    public query func getPosts() : async [Post] {
        Array.sort<Post>(posts, func(a, b) {
            if (a.timestamp > b.timestamp) { #less }
            else if (a.timestamp < b.timestamp) { #greater }
            else { #equal }
        })
    };
}
