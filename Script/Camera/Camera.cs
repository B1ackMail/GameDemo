using Godot;
using System;
using System.Data.Common;

public partial class Camera : Node
{
	private static Camera instance;
	public static Camera Getinstance()
	{
		return instance;
	}
}
