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

package com.freshplanet.ane.AirGameCenter {
public class AirGameCenterScore {
	private var _leaderboardId:String;
	private var _value:int;
	private var _formattedValue:String;
	private var _date:Date;
	private var _player:AirGameCenterPlayer;
	private var _rank:int;

	public function AirGameCenterScore(
			leaderboardId:String,
			value:int,
			formattedValue:String,
			date:Date,
			player:AirGameCenterPlayer,
			rank:int ) {
		_leaderboardId = leaderboardId;
		_value = value;
		_formattedValue = formattedValue;
		_date = date;
		_player = player;
		_rank = rank;
	}

	public function get leaderboardId():String {
		return _leaderboardId;
	}

	public function get value():int {
		return _value;
	}

	public function get formattedValue():String {
		return _formattedValue;
	}

	public function get date():Date {
		return _date;
	}

	public function get player():AirGameCenterPlayer {
		return _player;
	}

	public function get rank():int {
		return _rank;
	}
}
}
