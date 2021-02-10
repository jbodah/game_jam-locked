# Admin

## Building dialogue with YarnEditor

The YarnEditor interface is here: https://yarnspinnertool.github.io/YarnEditor/. We will use this to define the dialogue tree for each level. Levels should be exported from the editor in JSON format and then they can be uploaded. The goal is to get 90% of the way there with Yarn and then make tweaks in code.

### Anatomy of Yarn and How We'll Use It

[docs/1.png](docs/1.png)

The dialogue tree is made up of a bunch of trees (technically they are all one tree, but the root node is implicit - anything without a parent node is considered to be the child of the root node).
For the sake of simplicity, I will treat these as multiple trees going forward and when I say "root node" I mean any node that doesn't have a parent.

Each node has an id, a body, and a set of tags.
A node can have child nodes (which are called "subsections" in our game) and links to those child nodes are specified in the body via `[[some child id]]` links.
Additionally node have tags which allow you to add various metadata (e.g. which camera do we zoom in to, are there flags we need to check, are there flags we need to set, are the sounds we need to play, etc).

The most important tag is the `type:` tag.
Every node can have a type and the body of that type is interpreted differently depending on the type of the node.
If a node does not have a type then the node is considered a `simple` type.
Most nodes interpret their body as literal text, however other nodes like `multi_visit` and `branch` nodes follow special rules.
I will explain these in more detail in a second.

For the most part, id's don't have any meaning.
There are some exceptions however:

* The `_intro` node is always played immediately when the scene is rendered
* The `_hint` node is a special node that is called when the hint button is pressed
* The `_outro` node is a special node that is called before we exit the scene (e.g. when the player completes the level)
* The other root nodes are all clickable entities and their names will be used to match them to hitboxes

### Types of Nodes

Every node should have a type (with the exception of `simple` nodes which are used for simple text messages).
All of the supported types are defined in [api.rb](api.rb):

[https://github.com/jbodah/game_jam-locked/blob/20c56fbc308374f0396fe45bec66f23f01d0110c/api.rb#L43-L61](https://github.com/jbodah/game_jam-locked/blob/20c56fbc308374f0396fe45bec66f23f01d0110c/api.rb#L43-L61)

I will cover a few of the more interesting ones here. In addition, nodes have properties and some of those properties are global meaning they can be used with any node.

The global properties are:

* `set_flag:SOME_FLAG_NAME` this will set the given flag when this node is shown to the player. Note that _no_ flags are ever set automatically (even computers unlocking)
* `sound_open:some_sound_name` this will play the given sound when the node is shown to the player

### Node type reference

`camera_zoom`
* Requires a `camera:` tag which specifies which camera to zoom into
* The body of this node specifies the nodes that should play after we have zoomed in to the camera
* The zoom out will play after this node and all of its children finish

`sequence`
* This plays each of its children in-order to completion
* Children by default are ignored without this - that is a feature I want to eventually get rid of
* A sequence is important when we want to do things like have a choice then some text then a choice then a sticky note then some text

`simple`
* For showing simple text
* This is the default node type
* The body of this node will be one or many messages. There is nuance here as to how this renders (to prevent overflow) but don't worry about it too much, we'll tweak it later

`sticky_note`/`calendar`
* Renders a sticky note/calendar
* body will become the text of the sticky note/calendar

`multi_visit`
* This is a meta-type
* The body should have two links: `[[first_visit|some child id]]` and `[[else|some other child id]]`

`choose`
* This is a meta-type
* The body should be links to each of the possible choice nodes

`choice`
* This represents a dialogue choice
* This can have the `if_flag` or `not_if_flag` tags to only present a choice if/not if some condition is set
* The body should be the text of the choice as well as link to what happens after that choice is made

`branch`
* This is a meta-type
* The body should be two links of the forms `[[if SOME_FLAG_NAME|some child id]]` and `[[else|some other child id]]`

`password`
* This will prompt the user for a password
* Feel free to represent this however for right now

`search_engine`
* This brings up Goojle

`close`
* This node auto closes. It is used for things like drinking coffee without showing text and just playing the sound

### Example

There is an example JSON file at [example_yarn.json](example_yarn.json). If you are looking for examples for how nodes are used, you can also look at the level files like [level1.rb](level1.rb)
