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
public class AirGameCenterPlayer {
	private var _id : String;
	private var _alias : String;
	private var _displayName : String;

	public function AirGameCenterPlayer(id:String, alias:String, displayName:String) {
		_id = id;
		_alias = alias;
		_displayName = displayName;
	}

	public function get id():String {
		return _id;
	}

	public function get alias():String {
		return _alias;
	}

	public function get displayName():String {
		return _displayName;
	}

}
}
