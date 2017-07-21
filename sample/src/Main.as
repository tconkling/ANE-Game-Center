/*
 * Copyright 2017 FreshPlanet
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package {

import com.freshplanet.ane.AirGameCenter.AirGameCenter;
import com.freshplanet.ane.AirGameCenter.AirGameCenterAchievement;
import com.freshplanet.ane.AirGameCenter.AirGameCenterLeaderboard;
import com.freshplanet.ane.AirGameCenter.AirGameCenterPlayer;
import com.freshplanet.ane.AirGameCenter.events.AirGameCenterAchievementEvent;
import com.freshplanet.ane.AirGameCenter.events.AirGameCenterEvent;
import com.freshplanet.ane.AirGameCenter.events.AirGameCenterLeaderboardEvent;
import com.freshplanet.ane.AirGameCenter.events.AirGameCenterPhotoEvent;
import com.freshplanet.ane.AirGameCenter.events.AirGameCenterRecentPlayersEvent;

import flash.display.BitmapData;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.events.Event;

import com.freshplanet.ui.ScrollableContainer;
import com.freshplanet.ui.TestBlock;

[SWF(backgroundColor="#057fbc", frameRate='60')]
public class Main extends Sprite {

    public static var stageWidth:Number = 0;
    public static var indent:Number = 0;

    private var _scrollableContainer:ScrollableContainer = null;

    public function Main() {
        this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        this.removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        this.stage.align = StageAlign.TOP_LEFT;

        stageWidth = this.stage.stageWidth;
        indent = stage.stageWidth * 0.025;

        _scrollableContainer = new ScrollableContainer(false, true);
        this.addChild(_scrollableContainer);

        if (!AirGameCenter.isSupported) {
            trace("AirGameCenter ANE is NOT supported on this platform!");
            return;
        }

	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.AUTHENTICATED, onAuthenticated);
	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.AUTHENTICATION_FAILED, onAuthenticationFailed);
	    AirGameCenter.instance.addEventListener(AirGameCenterLeaderboardEvent.LOAD_COMPLETE, onLeaderboardsLoaded);
	    AirGameCenter.instance.addEventListener(AirGameCenterLeaderboardEvent.LOAD_ERROR, onLeaderboardsLoadError);
	    AirGameCenter.instance.addEventListener(AirGameCenterAchievementEvent.LOAD_COMPLETE, onAchievementsLoaded);
	    AirGameCenter.instance.addEventListener(AirGameCenterAchievementEvent.LOAD_ERROR, onAchievementsLoadError);
	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.SCORE_REPORTED, onScoreReported);
	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.SCORE_REPORT_FAILED, onScoreReportFailed);
	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.ACHIEVEMENT_REPORTED, onAchievementReported);
	    AirGameCenter.instance.addEventListener(AirGameCenterEvent.ACHIEVEMENT_REPORT_FAILED, onAchievementReportFailed);
	    AirGameCenter.instance.addEventListener(AirGameCenterRecentPlayersEvent.LOAD_COMPLETE, onRecentPlayersLoaded);
	    AirGameCenter.instance.addEventListener(AirGameCenterRecentPlayersEvent.LOAD_ERROR, onRecentPlayersError);
	    AirGameCenter.instance.addEventListener(AirGameCenterPhotoEvent.LOAD_COMPLETE, onPhotoLoadComplete);
	    AirGameCenter.instance.addEventListener(AirGameCenterPhotoEvent.LOAD_ERROR, onPhotoLoadError);

        var blocks:Array = [];

	    blocks.push(new TestBlock("is authenticated", function():void {
		    trace("Is authenticated ", AirGameCenter.instance.isAuthenticated);
	    }));
        blocks.push(new TestBlock("authenticate", function():void {
	        AirGameCenter.instance.authenticateLocalPlayer();
        }));
	    blocks.push(new TestBlock("load achievements", function():void {
		    AirGameCenter.instance.loadAchievements();
	    }));
	    blocks.push(new TestBlock("load leaderboards", function():void {
		    AirGameCenter.instance.loadLeaderboards();
	    }));
	    blocks.push(new TestBlock("get local player", function():void {
		    var player:AirGameCenterPlayer = AirGameCenter.instance.localPlayer;
		    if(player)
		    {
			    trace("player id", player.id);
			    trace("player alias", player.alias);
			    trace("player displayName", player.displayName);
		    }

	    }));
	    blocks.push(new TestBlock("load recent players", function():void {
		    AirGameCenter.instance.loadRecentPlayers();
	    }));
	    blocks.push(new TestBlock("show leaderboard", function():void {
		    AirGameCenter.instance.showLeaderboard();
	    }));
	    blocks.push(new TestBlock("show achievements", function():void {
		    AirGameCenter.instance.showAchievements();
	    }));
	    blocks.push(new TestBlock("report score", function():void {
		    AirGameCenter.instance.reportScore("YOUR-LEADERBOARD-ID", 100);
	    }));
	    blocks.push(new TestBlock("report achievement", function():void {
		    AirGameCenter.instance.reportAchievement("YOUR-ACHIEVEMENT-ID", true, 100);
	    }));
	    blocks.push(new TestBlock("load player photo", function():void {
			AirGameCenter.instance.loadPlayerPhoto("PLAYER-ID");
	    }));

        /**
         * add ui to screen
         */

        var nextY:Number = indent;

        for each (var block:TestBlock in blocks) {

            _scrollableContainer.addChild(block);
            block.y = nextY;
            nextY +=  block.height + indent;
        }
    }

	private function onAuthenticated(event:AirGameCenterEvent):void {
		trace("Authentication success");
	}

	private function onAuthenticationFailed(event:AirGameCenterEvent):void {
		trace("Authentication failed with error ", event.error);
	}

	private function onLeaderboardsLoaded(event:AirGameCenterLeaderboardEvent):void {
		var leaderboards:Vector.<AirGameCenterLeaderboard> = event.leaderboards;
		trace("Leaderboards load success");
	}

	private function onLeaderboardsLoadError(event:AirGameCenterLeaderboardEvent):void {
		trace("Leaderboards load failed with error ", event.error);
	}

	private function onAchievementsLoaded(event:AirGameCenterAchievementEvent):void {
		var achievements:Vector.<AirGameCenterAchievement> = event.achievements;
		trace("Achievements load success");
	}

	private function onAchievementsLoadError(event:AirGameCenterAchievementEvent):void {
		trace("Achievements load failed with error ", event.error);
	}

	private function onScoreReported(event:AirGameCenterEvent):void {
		trace("Score report success");
	}

	private function onScoreReportFailed(event:AirGameCenterEvent):void {
		trace("Score report failed with error ", event.error);
	}

	private function onAchievementReported(event:AirGameCenterEvent):void {
		trace("Achievement report success");
	}

	private function onAchievementReportFailed(event:AirGameCenterEvent):void {
		trace("Report achievement failed with error ", event.error);
	}

	private function onRecentPlayersLoaded(event:AirGameCenterRecentPlayersEvent):void {
		var players:Vector.<AirGameCenterPlayer> = event.players;
		trace("Recent players load complete");
	}

	private function onRecentPlayersError(event:AirGameCenterRecentPlayersEvent):void {
		trace("Recent players load failed with error ", event.error);
	}

	private function onPhotoLoadComplete(event:AirGameCenterPhotoEvent):void {
		var photo:BitmapData = event.photo;
		trace("Photo load complete");
	}

	private function onPhotoLoadError(event:AirGameCenterPhotoEvent):void {
		trace("Photo load failed with error : ", event.error);
	}



}
}
