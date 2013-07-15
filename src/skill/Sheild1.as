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
	
	public class Sheild1 extends HotkeyTrigger
	{
		public static const ID: String = "sheild1";
		public function Sheild1()
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
				skillTarget = Scene.instance.player;
			}
			prepareSkill(skillTarget);
		}
		
		protected static function prepareSkill(target: BitmapDisplay): void
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
			
			var sheild: StatusEffectDisplay = new StatusEffectDisplay(evt.skillId, evt.skillTarget);
			sheild.owner = Scene.instance.player;
			sheild.graphic = ResourcePool.instance.getResourceData("assets.skill." + ID);
			sheild.render = new Render();
			Scene.instance.player.addDisplay(sheild);
		}
		
		public static function showSkillPrepare(owner: BitmapDisplay, target: BitmapDisplay): void
		{
			var effect: SingEffectDisplay = new SingEffectDisplay(ID, target);
			effect.owner = owner;
			effect.graphic = ResourcePool.instance.getResourceData("assets.skill.prepareSkill");
			effect.singTime = 1000;
			effect.render = new Render();
			owner.addDisplay(effect);
		}
		
		public static function showSkillFire(owner: BitmapDisplay, target: BitmapDisplay): void
		{
			var sheild: StatusEffectDisplay = new StatusEffectDisplay(ID, target);
			sheild.owner = owner;
			sheild.graphic = ResourcePool.instance.getResourceData("assets.skill." + ID);
			sheild.render = new Render();
			target.addDisplay(sheild);
		}
	}
}