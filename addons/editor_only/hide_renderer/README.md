![icon](/images/icon.png)

# Hide renderer switch for Godot 4.x

Toggle the visibility of the rendering switch button with ease using this add-on!

After this [pull request](https://github.com/godotengine/godot/pull/70500) in Godot 4.x, a switch was returned to quickly change the rendering backend, but as for me it takes up too much space and I just don't need it.

Under the hood, this switch simply changes this setting in `ProjectSettings` (`rendering/renderer/rendering_method`):
![rendering/renderer/rendering_method](/images/rendering_method.png)

## Installation

To download, use the [Godot Asset Library](https://godotengine.org/asset-library/asset/NO_LINK_FOR_THE_MOMENT) or download the archive by clicking the button at the top of the main repository page: `Code -> Download ZIP`, then unzip it to your project folder. Or use one of the versions from the [GitHub Releases page](https://github.com/DmitriySalnikov/godot_hide_renderer_switch/releases) (just download one of the "Source Codes" in assets).

* Copy the `addons` folder to your project
* Activate the `Hide Renderer Switch` plugin

If necessary, you can restore the visibility of the switch in the editor settings (`interface/editor/show_renderer_switch`) or simply by disabling this plugin.

![installation.gif](/images/installation.gif)
