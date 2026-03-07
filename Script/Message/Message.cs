using Godot;
using System;

public partial class Message : Node
{
	// Called when the node enters the scene tree for the first time.
	private static Message instance;
	public static Message Getinstance()
	{
		return instance;
	}
}
