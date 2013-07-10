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
		public function Sheild1()
		{
			super();
			_id = "sheild1";
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
			prepareSkill(_id, skillTarget);
		}
		
		protected static function prepareSkill(skillId: String, target: BitmapDisplay): void
		{
			var effect: SingEffectDisplay = new SingEffectDisplay(skillId, target);
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
			sheild.graphic = ResourcePool.instance.getResourceData("assets.skill.sheild1");
			sheild.render = new Render();
			Scene.instance.player.addDisplay(sheild);
		}
		
		public static function showSkillPrepare(owner: BitmapDisplay, skillId: String, target: BitmapDisplay): void
		{
			var effect: SingEffectDisplay = new SingEffectDisplay(skillId, target);
			effect.owner = owner;
			effect.graphic = ResourcePool.instance.getResourceData("assets.skill.prepareSkill");
			effect.singTime = 1000;
			effect.render = new Render();
			owner.addDisplay(effect);
		}
		
		public static function showSkillFire(owner: BitmapDisplay, skillId: String, target: BitmapDisplay): void
		{
			var sheild: StatusEffectDisplay = new StatusEffectDisplay(skillId, target);
			sheild.owner = owner;
			sheild.graphic = ResourcePool.instance.getResourceData("assets.skill.sheild1");
			sheild.render = new Render();
			target.addDisplay(sheild);
		}
	}
}