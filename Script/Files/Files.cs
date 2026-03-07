using Godot;
using System;

public partial class Files : Node
{
	private static Files instance;

	public static Files GetInstance()
	{
		return instance;
	}
}
