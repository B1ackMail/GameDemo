using Godot;
using System;




/// <summary>
/// 统一管理游戏所有的Manager,将分散的功能整合
/// </summary>
public partial class GameManager : Node
{
	
	
	/*游戏中所有的Manager 统一由GameMainManager管理 外部访问一律经过GameMainManager*/
	/// <summary>
	/// 资源加载
	/// </summary>
	public  AssetLoader assetLoader ;
	/// <summary>
	/// 相机管理
	/// </summary>
	public Camera camera ;
	/// <summary>
	/// 存档管理
	/// </summary>
	public  Files files;
	/// <summary>
	/// 输入管理
	/// </summary>
	public Input input;
	/// <summary>
	/// 游戏时间缩放管理
	/// </summary>
	public TimeScale timeScale;
	/// <summary>
	/// 游戏UI管理
	/// </summary>
	public UI ui;
	/// <summary>
	/// 游戏事件管理( 待实现 )
	/// </summary>
	//public static GameEventManager Event => mGameEventManager;
	//private static GameEventManager mGameEventManager;
	/// <summary>
	/// 游戏场景管理
	/// </summary>
	public Scene scene;
	/// <summary>
	/// 游戏物品行为管理
	/// </summary>
	public PropsBehavier propBehavior;
	/// <summary>
	/// 游戏增益效果管理
	/// </summary>
	public Buff buff;
	/// <summary>
	/// 游戏对话管理
	/// </summary>
	public Dialogue dialogue;
	/// <summary>
	/// 游戏任务管理
	/// </summary>
	public Quest quest;
	/// <summary>
	/// 游戏消息管理
	/// </summary>
	public Message message;
	/// <summary>
	/// 游戏音频管理
	/// </summary>
	public  Audio audio;





	public AudioStreamPlayer BGMAudioSource;
	public AudioStreamPlayer UIAudioSource;
	public AudioStreamPlayer SceneAudioSource;
	private static GameManager instance;
	public static GameManager Getinstance()
	{
		return instance;
	}
	public override void _Ready()
	{
		instance = this;
		//mGameEventManager = new GameEventManager();
		assetLoader = new AssetLoader();
		files = new Files();
		ui = new UI();
		input = new Input();
		timeScale = new TimeScale();
		scene = new Scene();
		camera = new Camera();
		buff = new Buff();
		propBehavior = new PropsBehavier();
		dialogue = new Dialogue();
		quest = new Quest();
		message = new Message();
		audio = new Audio(BGMAudioSource,SceneAudioSource,UIAudioSource);
		
	}
	
}
