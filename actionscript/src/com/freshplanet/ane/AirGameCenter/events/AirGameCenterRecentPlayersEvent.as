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

package com.freshplanet.ane.AirGameCenter.events {
import com.freshplanet.ane.AirGameCenter.AirGameCenterPlayer;

import flash.events.Event;

public class AirGameCenterRecentPlayersEvent extends Event {

	public static const LOAD_COMPLETE:String = "AirGameCenterRecentPlayersEvent_playersLoadComplete";
	public static const LOAD_ERROR:String = "AirGameCenterRecentPlayersEvent_playersLoadError";

	private var _error:String;
	private var _players:Vector.<AirGameCenterPlayer>;

	public function AirGameCenterRecentPlayersEvent(type:String, players:Vector.<AirGameCenterPlayer>, error:String = null, bubbles:Boolean = false, cancelable:Boolean = false) {
		super(type, bubbles, cancelable);
		_players = players;
		_error = error;
	}

	public function get error():String {
		return _error;
	}

	public function get players():Vector.<AirGameCenterPlayer> {
		return _players;
	}
}
}
