using Godot;
using System;

public partial class TimeScale : Node
{
	private static TimeScale instance;
	public static TimeScale Getinstance()
	{
		return instance;
	}
}
