using Godot;
using System;

public partial class Pool : Node
{
	private static Pool instance;
	public static Pool Getinstance()
	{
		return instance;
	}
}
