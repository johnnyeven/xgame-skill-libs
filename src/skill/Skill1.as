package skill
{
	import com.xgame.common.display.AutoRemoveEffectDisplay;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.SingEffectDisplay;
	import com.xgame.common.display.StatusEffectDisplay;
	import com.xgame.common.display.TrackEffectDisplay;
	import com.xgame.common.display.renders.Render;
	import com.xgame.common.pool.ResourcePool;
	import com.xgame.core.HotkeyTrigger;
	import com.xgame.core.map.Map;
	import com.xgame.core.scene.Scene;
	import com.xgame.events.SkillEvent;
	import com.xgame.utils.debug.Debug;
	
	import flash.geom.Point;

	public class Skill1 extends HotkeyTrigger
	{
		public static const ID: String = "skill1";
		
		public function Skill1()
		{
			super();
		}
		
		public static function execute(): void
		{
			var skillTarget: *;
			if(Scene.instance.player.locker != null)
			{
				skillTarget = Scene.instance.player.locker;
			}
			else
			{
				skillTarget = Map.instance.getWorldPosition(Scene.instance.stage.mouseX, Scene.instance.stage.mouseY);
			}
			prepareSkill(skillTarget);
		}
		
		protected static function prepareSkill(target: *): void
		{
			var effect: SingEffectDisplay = new SingEffectDisplay(ID, target);
			effect.owner = Scene.instance.player;
			effect.graphic = ResourcePool.instance.getResourceData("assets.skill.prepareSkill");
			effect.singTime = 1000;
			effect.render = new Render();
			effect.addEventListener(SkillEvent.SING_COMPLETE, skillFire, false, 0, true);
			Scene.instance.player.addDisplay(effect);
		}
		
		protected static function skillFire(evt: SkillEvent): void
		{
			(evt.currentTarget as SingEffectDisplay).removeEventListener(SkillEvent.SING_COMPLETE, skillFire);
			
			var tracker: TrackEffectDisplay;
			for(var i: int = 0; i < 5; i++)
			{
				tracker = new TrackEffectDisplay(evt.skillId, evt.skillTarget, new Point(Scene.instance.player.positionX, Scene.instance.player.positionY), .1, i);
				tracker.owner = Scene.instance.player;
				tracker.graphic = ResourcePool.instance.getResourceData("assets.skill." + evt.skillId + "_FIRE");
				tracker.render = new Render();
				tracker.addEventListener(SkillEvent.FIRE_COMPLETE, skillExplode, false, 0, true);
				Scene.instance.addObject(tracker);
			}
		}
		
		protected static function skillExplode(evt: SkillEvent): void
		{
			Debug.info(evt.currentTarget, evt.currentTarget.name);
			(evt.currentTarget as TrackEffectDisplay).removeEventListener(SkillEvent.FIRE_COMPLETE, skillExplode);
			var explode: AutoRemoveEffectDisplay = new AutoRemoveEffectDisplay(evt.skillId, evt.skillTarget);
			explode.owner = Scene.instance.player;
			explode.graphic = ResourcePool.instance.getResourceData("assets.skill." + evt.skillId + "_EXPLODE");
			explode.render = new Render();
			
			if(evt.skillTarget is BitmapDisplay)
			{
				(evt.skillTarget as BitmapDisplay).addDisplay(explode);
			}
			else
			{
				Scene.instance.addObject(explode);
			}
		}
		
		public static function showSkillPrepare(owner: BitmapDisplay, target: *): void
		{
			var effect: SingEffectDisplay = new SingEffectDisplay(ID, target);
			effect.owner = owner;
			effect.graphic = ResourcePool.instance.getResourceData("assets.skill.prepareSkill");
			effect.singTime = 1000;
			effect.render = new Render();
//			effect.addEventListener(SkillEvent.SING_COMPLETE, skillFire, false, 0, true);
			owner.addDisplay(effect);
		}
		
		public static function showSkillFire(owner: BitmapDisplay, target: *): void
		{
			var tracker: TrackEffectDisplay;
			for(var i: int = 0; i < 5; i++)
			{
				tracker = new TrackEffectDisplay(ID, target, new Point(owner.positionX, owner.positionY), .1, i);
				tracker.owner = owner;
				tracker.graphic = ResourcePool.instance.getResourceData("assets.skill." + ID + "_FIRE");
				tracker.render = new Render();
//				tracker.addEventListener(SkillEvent.FIRE_COMPLETE, skillExplode, false, 0, true);
				Scene.instance.addObject(tracker);
			}
		}
		
		public static function showSkillExplode(owner: BitmapDisplay, target: *): void
		{
			Debug.info(target, target.name);
			var explode: AutoRemoveEffectDisplay = new AutoRemoveEffectDisplay(ID, target);
			explode.owner = owner;
			explode.graphic = ResourcePool.instance.getResourceData("assets.skill." + ID + "_EXPLODE");
			explode.render = new Render();
			
			if(target is BitmapDisplay)
			{
				(target as BitmapDisplay).addDisplay(explode);
			}
			else
			{
				Scene.instance.addObject(explode);
			}
		}
	}
}