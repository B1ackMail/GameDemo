using Godot;
using System;

public partial class Input : Node
{
	private static Input instance;
	public static Input Getinstance()
	{
		return instance;
	}
	public bool inputbackward;
}
