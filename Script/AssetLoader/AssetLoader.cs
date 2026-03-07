using Godot;
using System;

public partial class AssetLoader : Node
{
	private static AssetLoader instance;
	public static AssetLoader Getinstance()
	{
		if (instance == null)
		{
			return instance;
		}
		return instance;
	}
}
