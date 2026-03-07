using System;
using Godot;
public partial class Audio : Node
{
	public AudioStreamPlayer BGMAudioSource;
	public AudioStreamPlayer SceneEffectAudioSource;
	public AudioStreamPlayer UIEffectAudioSource;
	private bool begingBGM;

	private static Audio instance;
	public static Audio GetInstance()
	{
			if (instance == null)
			{
				return instance;
			}
			else
			return instance;
	}
	public Audio(AudioStreamPlayer BGM, AudioStreamPlayer SceneEffect, AudioStreamPlayer UIEffect)
	{
		BGMAudioSource = BGM;
		SceneEffectAudioSource = SceneEffect;
		UIEffectAudioSource = UIEffect;
	}
}
