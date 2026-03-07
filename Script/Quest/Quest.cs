using Godot;
using System;

public partial class Quest : Node
{private static Quest instance;
	public static Quest Getinstance()
	{
		return instance;
	}
}
