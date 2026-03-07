using Godot;
using System;

public partial class Scene : Node
{
	private static Scene instance;
	public static  Scene Getinstance()
	{
		return instance;
	}
}
