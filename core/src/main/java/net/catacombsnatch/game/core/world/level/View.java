package net.catacombsnatch.game.core.world.level;

import net.catacombsnatch.game.core.resource.Art;
import net.catacombsnatch.game.core.scene.Scene;
import net.catacombsnatch.game.core.screen.Renderable;
import net.catacombsnatch.game.core.screen.Screen;
import net.catacombsnatch.game.core.screen.Updateable;
import net.catacombsnatch.game.core.world.tile.Tile;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector2;

public class View implements Renderable, Updateable {
	protected Level level;
	protected Rectangle viewport;
	protected int rendered;
	protected Vector2 offset, target;
	
	protected Sprite panel;
	
	protected Minimap minimap;
	
	public View(Level lvl) {
		level = lvl;
		
		offset = new Vector2();
		panel = new Sprite(Art.skin.getAtlas().findRegion("player-panel"));
		
		minimap = new Minimap(level, this);
	}
	
	@Override
	public void render( Scene scene ) {
		if(viewport == null) return;
		
		// "Camera" movement
		offset = target.lerp(offset, Gdx.graphics.getDeltaTime());
		
		// Draw tiles
		rendered = 0; // Reset counter
		
		//for(float y = (viewport.height + offset.y) / Tile.HEIGHT + 2; y >= (viewport.y + offset.y) / Tile.HEIGHT - 4; y--) {
		for(float y = (viewport.y - offset.y) / Tile.HEIGHT - 4; y <= (viewport.height - offset.y) / Tile.HEIGHT + 2; y++) {
			for(float x = (viewport.x + offset.x) / Tile.WIDTH - 2; x < (viewport.width + offset.x) / Tile.WIDTH + 4; x++) {
				Tile tile = level.getTile((int) x, (int) y);
				
				if(tile != null && tile.shouldRender(this)) {
					tile.render(scene.getSpriteBatch(), this);
					rendered++;
				}
			}
		}
		
		panel.draw(scene.getSpriteBatch());
		
		minimap.render(scene);
	}
	
	@Override
	public void update(boolean resize) {
		if(viewport == null) return;
		
		panel.setPosition((viewport.getWidth() - panel.getWidth()) / 2, viewport.getHeight() - panel.getHeight());
		
		minimap.update(true);
	}

	/**
	 * Moves the view offset.
	 * 
	 * @param x Amount of pixels to move along the x-coordinate
	 * @param y Amount of pixels to move along the y-coordinate
	 */
	public void setTarget(float x, float y) {
		target = new Vector2(x, y);
	}
	
	public void setViewport(Rectangle view) {
		viewport = view;
	}
	
	/** @return The number of tiles rendered during the last {@link #render(Screen)} call. */
	public int getLastRenderedTileCount() {
		return rendered;
	}
	
	/** @return The current view offset. */
	public Vector2 getOffset() {
		return offset;
	}
	
	/** @return The current view port. */
	public Rectangle getViewport() {
		return viewport;
	}
	
	/** @return The current view port + offset. */
	public Rectangle getViewportOffset() {
		Rectangle r = new Rectangle(viewport);
		r.setX(viewport.x+offset.x);
		r.setY(viewport.y-offset.y);
		return r;
	}

}
