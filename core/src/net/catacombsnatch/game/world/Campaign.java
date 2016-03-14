package net.catacombsnatch.game.world;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;

import net.catacombsnatch.game.player.Player;
import net.catacombsnatch.game.screen.Tickable;
import net.catacombsnatch.game.util.Finishable;
import net.catacombsnatch.game.world.level.Level;

public class Campaign implements Tickable, Finishable {
	
	protected List<Level> levels;
	protected List<Player> players;

	protected final Difficulty difficulty;
	protected final MapRotation rotation;
	
	protected Level currentLevel;
	
	protected boolean hasFinished;

	public Campaign( Difficulty diff, MapRotation rot ) {
		levels = new LinkedList<Level>();
		players = new ArrayList<Player>();

		difficulty = diff;
		rotation = rot;
		hasFinished = false;
	}

	@Override
	public void tick(float delta) {
		if(hasFinished()) return;
		
		if(currentLevel == null || currentLevel.hasFinished()) {
			Level next = getRotation().getNext(getLevels());
			if(next == null) {
				setFinished(true);
				return;
			}
			
			currentLevel = next;
		}
		
		currentLevel.tick(delta);
	}

	@Override
	public void setFinished(boolean finished) {
		this.hasFinished = finished;
	}

	@Override
	public boolean hasFinished() {
		return hasFinished;
	}
	
	/** @return The current level that is being played in. */
	public Level getCurrentLevel() {
		return currentLevel;
	}
	
	/**
	 * Returns a list of levels inside this world.
	 * 
	 * @return The list of levels in this world
	 */
	public List<Level> getLevels() {
		return levels;
	}

	/**
	 * Returns a list of players inside this world
	 * 
	 * @return The list of players in this world
	 */
	public List<Player> getPlayers() {
		return players;
	}
	
	/**
	 * Returns the world's difficulty.
	 * 
	 * @return The {@link Difficulty}
	 */
	public Difficulty getDifficulty() {
		return difficulty;
	}
	
	/**
	 * Returns the map rotation type.
	 * 
	 * @return The {@link MapRotation}
	 */
	public MapRotation getRotation() {
		return rotation;
	}
	
	/**
	 * Defines the next level returned by {@link #getNext(List)}.
	 * <ul>
	 * <li><code>FIRST</code> only plays the first map (best used in campaigns with only one map)</li>
	 * <li><code>ONCE</code> same as linear (see below) but will not jump back to the beginning (no endless mode)</li>
	 * <li><code>LINEAR</code> chooses the next map in the level list.</li>
	 * <li><code>RANDOM</code> chooses a random level as the next one.</li>
	 * </ul>
	 */
	public abstract static class MapRotation {
		public final static class FIRST extends MapRotation {
			@Override
			public Level getNext(List<Level> levels) {
				return levels.size() == 0 ? null : levels.get(0);
			}
		}
		
		public final static class ONCE extends MapRotation {
			protected int next = 0;
			
			@Override
			public Level getNext(List<Level> levels) {
				return next < levels.size() ? levels.get(next++): null;
			}
		}
		
		public final static class LINEAR extends MapRotation {
			protected int next = 0;
			
			@Override
			public Level getNext(List<Level> levels) {
				if(next >= levels.size()) next = 0;
				return levels.get(next);
			}
		}
		
		public final static class RANDOM extends MapRotation {
			protected Random r = new Random();
			
			@Override
			public Level getNext(List<Level> levels) {
				return levels.get(r.nextInt(levels.size()));
			}
		}
		
		/**
		 * Returns the next level that should be played.
		 * If no next level should be started this will return null.
		 * 
		 * @param levels The list of levels to choose from
		 * @return The next level, otherwise null.
		 */
		public abstract Level getNext(List<Level> levels);
	}
}
