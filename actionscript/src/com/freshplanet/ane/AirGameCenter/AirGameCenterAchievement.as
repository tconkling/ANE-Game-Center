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
public class AirGameCenterAchievement {

	private var _identifier:String;
	private var _percentComplete:Number;
	private var _completed:Boolean;
	private var _lastReportedDate:Date;

	public function AirGameCenterAchievement(
			identifier:String,
	        percentComplete:Number,
	        completed:Boolean,
			lastReportedDate:Date
	) {

		_identifier = identifier;
		_percentComplete = percentComplete;
		_completed = completed;
		_lastReportedDate = lastReportedDate;

	}

	public function get identifier():String {
		return _identifier;
	}

	public function get percentComplete():Number {
		return _percentComplete;
	}

	public function get completed():Boolean {
		return _completed;
	}

	public function get lastReportedDate():Date {
		return _lastReportedDate;
	}
}
}
