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
import com.freshplanet.ane.AirGameCenter.enums.AirGameCenterLeaderboardPlayerScope;
import com.freshplanet.ane.AirGameCenter.enums.AirGameCenterLeaderboardTimeScope;

public class AirGameCenterLeaderboard {
	private var _identifier:String;
	private var _title:String;
	private var _timeScope:AirGameCenterLeaderboardTimeScope;
	private var _playerScope:AirGameCenterLeaderboardPlayerScope;
	private var _rangeLocation:int;
	private var _rangeLength:int;
	private var _maxRange:int;
	private var _scores:Vector.<AirGameCenterScore>;
	private var _localPlayerScore:AirGameCenterScore;

	public function AirGameCenterLeaderboard(
			identifier:String,
			title:String,
			timeScope:AirGameCenterLeaderboardTimeScope,
	        playerScope:AirGameCenterLeaderboardPlayerScope,
	        rangeLocation:int,
	        rangeLength:int,
	        maxRange:int,
	        scores:Vector.<AirGameCenterScore>,
	        localPlayerScore:AirGameCenterScore

	) {
		_identifier = identifier;
		_title = title;
		_timeScope = timeScope;
		_playerScope = playerScope;
		_rangeLocation = rangeLocation;
		_rangeLength = rangeLength;
		_maxRange = maxRange;
		_scores = scores;
		_localPlayerScore = localPlayerScore;
	}

	public function get identifier():String {
		return _identifier;
	}

	public function get title():String {
		return _title;
	}

	public function get timeScope():AirGameCenterLeaderboardTimeScope {
		return _timeScope;
	}

	public function get playerScope():AirGameCenterLeaderboardPlayerScope {
		return _playerScope;
	}

	public function get rangeLocation():int {
		return _rangeLocation;
	}

	public function get rangeLength():int {
		return _rangeLength;
	}

	public function get maxRange():int {
		return _maxRange;
	}

	public function get scores():Vector.<AirGameCenterScore> {
		return _scores;
	}

	public function get localPlayerScore():AirGameCenterScore {
		return _localPlayerScore;
	}
}
}
