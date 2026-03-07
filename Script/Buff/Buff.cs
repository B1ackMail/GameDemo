using Godot;
using System;

public partial class Buff : Node
{
	private static Buff instance;
	public static Buff Getinstance()
	{
		if (instance == null)
		{
			return instance;
		}
		return instance;
	}
}
