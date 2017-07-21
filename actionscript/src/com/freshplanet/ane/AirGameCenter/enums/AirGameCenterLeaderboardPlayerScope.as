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

package com.freshplanet.ane.AirGameCenter.enums {
public class AirGameCenterLeaderboardPlayerScope {
	/***************************
	 *
	 * PUBLIC
	 *
	 ***************************/


	static public const GLOBAL                  : AirGameCenterLeaderboardPlayerScope = new AirGameCenterLeaderboardPlayerScope(Private, 0);
	static public const FRIENDS                 : AirGameCenterLeaderboardPlayerScope = new AirGameCenterLeaderboardPlayerScope(Private, 1);

	public static function fromValue(value:uint):AirGameCenterLeaderboardPlayerScope {

		switch (value)
		{
			case GLOBAL.value:
				return GLOBAL;
				break;
			case FRIENDS.value:
				return FRIENDS;
				break;
			default:
				return null;
				break;
		}
	}

	public function get value():uint {
		return _value;
	}

	/***************************
	 *
	 * PRIVATE
	 *
	 ***************************/

	private var _value:uint;

	public function AirGameCenterLeaderboardPlayerScope(access:Class, value:uint) {

		if (access != Private)
			throw new Error("Private constructor call!");

		_value = value;
	}
}
}
final class Private {}