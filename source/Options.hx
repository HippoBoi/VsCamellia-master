package;

import lime.app.Application;
import lime.system.DisplayMode;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;

import TitleState._camsave as _camsave;
import PlayState;

class OptionCategory
{
	private var _options:Array<Option> = new Array<Option>();
	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	
	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Category";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}
	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String { return throw "stub!"; };
	
	// Returns whether the label is to be updated.
	public function press():Bool { return throw "stub!"; }
	private function updateDisplay():String { return throw "stub!"; }
	public function left():Bool { return throw "stub!"; }
	public function right():Bool { return throw "stub!"; }
}



class DFJKOption extends Option
{
	private var controls:Controls;

	public function new(controls:Controls)
	{
		super();
		this.controls = controls;
	}

	public override function press():Bool
	{
		OptionsMenu.instance.openSubState(new KeyBindMenu());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Key Bindings";
	}
}

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;
		
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.cpuStrums ? "Light CPU Strums" : "CPU Strums stay static";
	}

}

class StepmaniaOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.sm = !FlxG.save.data.sm;
		
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.sm ? "New noteskin" : "Old noteskin";
	}

}

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.downscroll ? "Downscroll" : "Upscroll";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.ghost ? "Ghost Tapping" : "No Ghost Tapping";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy " + (!FlxG.save.data.accuracyDisplay ? "off" : "on");
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Song Position " + (!FlxG.save.data.songPosition ? "off" : "on");
	}
}

class DistractionsAndEffectsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.distractions = !FlxG.save.data.distractions;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Distractions " + (!FlxG.save.data.distractions ? "off" : "on");
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Reset Button " + (!FlxG.save.data.resetButton ? "off" : "on");
	}
}

class FlashingLightsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.flashing = !FlxG.save.data.flashing;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flashing Lights " + (!FlxG.save.data.flashing ? "off" : "on");
	}
}

class ShowInput extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.inputShow = !FlxG.save.data.inputShow;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.inputShow ? "Extended Score Info" : "Minimalized Info");
	}
}


class Judgement extends Option
{
	

	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}
	
	public override function press():Bool
	{
		return true;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames";
	}

	override function left():Bool {

		if (Conductor.safeFrames == 1)
			return false;

		Conductor.safeFrames -= 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return false;
	}

	override function getValue():String {
		return "Safe Frames: " + Conductor.safeFrames +
		" - SIK: " + HelperFunctions.truncateFloat(45 * Conductor.timeScale, 0) +
		"ms GD: " + HelperFunctions.truncateFloat(90 * Conductor.timeScale, 0) +
		"ms BD: " + HelperFunctions.truncateFloat(135 * Conductor.timeScale, 0) + 
		"ms SHT: " + HelperFunctions.truncateFloat(166 * Conductor.timeScale, 0) +
		"ms TOTAL: " + HelperFunctions.truncateFloat(Conductor.safeZoneOffset,0) + "ms";
	}

	override function right():Bool {

		if (Conductor.safeFrames == 20)
			return false;

		Conductor.safeFrames += 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();
		return true;
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Counter " + (!FlxG.save.data.fps ? "off" : "on");
	}
}

class ScoreScreen extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.scoreScreen = !FlxG.save.data.scoreScreen;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return (FlxG.save.data.scoreScreen ? "Show Score Screen" : "No Score Screen");
	}
}




class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "FPS Cap";
	}
	
	override function right():Bool {
		if (FlxG.save.data.fpsCap >= 290)
		{
			FlxG.save.data.fpsCap = 290;
			(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);
		}
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 10;
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		return true;
	}

	override function left():Bool {
		if (FlxG.save.data.fpsCap > 290)
			FlxG.save.data.fpsCap = 290;
		else if (FlxG.save.data.fpsCap < 60)
			FlxG.save.data.fpsCap = Application.current.window.displayMode.refreshRate;
		else
			FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 10;
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		return true;
	}

	override function getValue():String
	{
		return "Current FPS Cap: " + FlxG.save.data.fpsCap + 
		(FlxG.save.data.fpsCap == Application.current.window.displayMode.refreshRate ? "Hz (Refresh Rate)" : "");
	}
}


class ScrollSpeedOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Scroll Speed";
	}

	override function right():Bool {
		FlxG.save.data.scrollSpeed += 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 9)
			FlxG.save.data.scrollSpeed = 9;
		return true;
	}

	override function getValue():String {
		return "Current Scroll Speed: " + HelperFunctions.truncateFloat(FlxG.save.data.scrollSpeed,1);
	}

	override function left():Bool {
		FlxG.save.data.scrollSpeed -= 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 9)
			FlxG.save.data.scrollSpeed = 9;

		return true;
	}
}


class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		(cast (Lib.current.getChildAt(0), Main)).changeFPSColor(FlxColor.WHITE);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Rainbow " + (!FlxG.save.data.fpsRain ? "off" : "on");
	}
}

class Optimization extends Option
{
	public function new(desc:String)
		{
			super();
			description = desc;
		}
	
		public override function press():Bool
		{
			FlxG.save.data.optimize = !FlxG.save.data.optimize;
			display = updateDisplay();
			return true;
		}
	
		private override function updateDisplay():String
		{
			return "Optimization " + (FlxG.save.data.optimize ? "ON" : "OFF");
		}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "NPS Display " + (!FlxG.save.data.npsDisplay ? "off" : "on");
	}
}

class ReplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new LoadReplayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Load replays";
	}
}

class AccuracyDOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy Mode: " + (FlxG.save.data.accuracyMod == 0 ? "Accurate" : "Complex");
	}
}

class CustomizeGameplay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new GameplayCustomizeState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Customize Gameplay";
	}
}

class WatermarkOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		Main.watermarks = !Main.watermarks;
		FlxG.save.data.watermark = Main.watermarks;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Watermarks " + (Main.watermarks ? "on" : "off");
	}
}

class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		var poop:String = Highscore.formatSong("Tutorial", 1);

		PlayState.SONG = Song.loadFromJson(poop, "Tutorial");
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
	}
}
class BotPlay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}
	
	private override function updateDisplay():String
		return "BotPlay " + (FlxG.save.data.botplay ? "on" : "off");
}

class CamZoomOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.camzoom = !FlxG.save.data.camzoom;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zoom " + (!FlxG.save.data.camzoom ? "off" : "on");
	}
}

class Modcharts extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		_camsave.data.modcharts = !_camsave.data.modcharts;
		_camsave.flush();
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Modcharts " + (_camsave.data.modcharts ? "on" : "off");
	}
}

class ShowCharacters extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		_camsave.data.characters = !_camsave.data.characters;
		_camsave.flush();
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Show Characters " + (_camsave.data.characters ? "on" : "off");
	}
}

class CameraBumping extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		_camsave.data.cambump = !_camsave.data.cambump;
		_camsave.flush();
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Bumping " + (_camsave.data.cambump ? "on" : "off");
	}
}

class DamageMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Damage Mode";
	}

	override function right():Bool {
		_camsave.data.damagemode += 5;

		if (_camsave.data.damagemode < 0)
			_camsave.data.damagemode = 0;

		if (_camsave.data.damagemode > 95)
			_camsave.data.damagemode = 95;

		trace(_camsave.data.damagemode);

		_camsave.flush();

		return true;
	}

	override function getValue():String {
		return "It's random! "+ _camsave.data.damagemode + "%";
	}

	override function left():Bool {
		_camsave.data.damagemode -= 5;

		if (_camsave.data.damagemode < 0)
			_camsave.data.damagemode = 0;

		if (_camsave.data.damagemode > 95)
			_camsave.data.damagemode = 95;
		
		trace(_camsave.data.damagemode);

		_camsave.flush();

		return true;
	}
}

class HitNoise extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Hit Sounds";
	}

	override function right():Bool {
		_camsave.data.hitnoise += 0.1;

		if (_camsave.data.hitnoise < 0)
			_camsave.data.hitnoise = 0;

		if (_camsave.data.hitnoise > 1)
			_camsave.data.hitnoise = 1;

		trace(_camsave.data.hitnoise);

		_camsave.flush();

		return true;
	}

	override function getValue():String {
		return "Changes the volume of hit sounds! Volume = "+ _camsave.data.hitnoise * 100 + "%";
	}

	override function left():Bool {
		_camsave.data.hitnoise -= 0.1;

		if (_camsave.data.hitnoise < 0)
			_camsave.data.hitnoise = 0;

		if (_camsave.data.hitnoise > 1)
			_camsave.data.hitnoise = 1;
		
		trace(_camsave.data.hitnoise);

		_camsave.flush();

		return true;
	}
}

class HealthDrain extends Option
{
	public function new(desc:String)
		{
			super();
			description = desc;
			acceptValues = true;
		}
	
	public override function press():Bool
		{
			_camsave.data.draintoggle = !_camsave.data.draintoggle;
			_camsave.flush();
			display = updateDisplay();
			return true;
		}

	private override function updateDisplay():String
		{
			return "Health Drain " + (_camsave.data.draintoggle ? "On" : "Off");
		}
	
	override function right():Bool
	{
		_camsave.data.healthdrain += 0.2;

		if (_camsave.data.healthdrain < 1)
			_camsave.data.healthdrain = 1;

		if (_camsave.data.healthdrain > 100)
			_camsave.data.healthdrain = 100;

		trace(_camsave.data.healthdrain);

		_camsave.flush();

		return true;
	}
	override function left():Bool
	{
		_camsave.data.healthdrain -= 0.2;

		if (_camsave.data.healthdrain < 1)
			_camsave.data.healthdrain = 1;

		if (_camsave.data.healthdrain > 100)
			_camsave.data.healthdrain = 100;

		trace(_camsave.data.healthdrain);

		_camsave.flush();

		return true;
	}

	override function getValue():String {
		return "IN TESTING!! Boyfriend fights back! "+_camsave.data.healthdrain+" times the damage, deals "+(0.005 * _camsave.data.healthdrain)*100+"% per hit";
	}

}

class CMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		_camsave.data.cmode = !_camsave.data.cmode;
		_camsave.flush();
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "C-Mode " + (_camsave.data.cmode ? "on" : "off");
	}
}

class Vocals extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		_camsave.data.vocals = !_camsave.data.vocals;
		_camsave.flush();
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Vocals " + (_camsave.data.vocals ? "on" : "off");
	}
}
