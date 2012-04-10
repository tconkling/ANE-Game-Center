package com.sticksports.nativeExtensions.gameCenter
{
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import org.osflash.signals.Signal;

	public class GameCenter
	{
		public static var localPlayerAuthenticated : Signal = new Signal();
		public static var localPlayerNotAuthenticated : Signal = new Signal();
		public static var localPlayerFriendsLoadComplete : Signal = new Signal( Array );
		public static var localPlayerFriendsLoadFailed : Signal = new Signal();
		public static var leaderboardLoadComplete : Signal = new Signal( GCLeaderboard );
		public static var leaderboardLoadFailed : Signal = new Signal();
		public static var localPlayerScoreLoadComplete : Signal = new Signal( GCLeaderboard );
		public static var localPlayerScoreLoadFailed : Signal = new Signal();
		public static var localPlayerScoreReported : Signal = new Signal();
		public static var localPlayerScoreReportFailed : Signal = new Signal();
		public static var localPlayerAchievementReported : Signal = new Signal();
		public static var localPlayerAchievementReportFailed : Signal = new Signal();
		public static var gameCenterViewRemoved : Signal = new Signal();
		
		public static var isAuthenticating : Boolean;
		
		private static var _isSupported : Boolean;
		private static var _isSupportedTested : Boolean;
		private static var _isAuthenticated : Boolean;
		private static var _isAuthenticatedTested : Boolean;
		
		private static var _localPlayer : GCLocalPlayer;
		private static var _localPlayerTested : Boolean;
		
		private static var extensionContext : ExtensionContext = null;
		private static var initialised : Boolean = false;
		
		/**
		 * Initialise the extension
		 */
		public static function init() : void
		{
			if ( !initialised )
			{
				initialised = true;
				
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.GameCenter", null );
				extensionContext.call( NativeMethods.initNativeCode );
				
				extensionContext.addEventListener( StatusEvent.STATUS, handleStatusEvent );
			}
		}
		
		private static function handleStatusEvent( event : StatusEvent ) : void
		{
			trace( "internal event", event.level );
			switch( event.level )
			{
				case InternalMessages.localPlayerAuthenticated :
					isAuthenticating = false;
					_isAuthenticated = true;
					_isAuthenticatedTested = true;
					_localPlayerTested = false;
					localPlayerAuthenticated.dispatch();
					break;
				case InternalMessages.localPlayerNotAuthenticated :
					isAuthenticating = false;
					_isAuthenticated = false;
					_isAuthenticatedTested = true;
					_localPlayerTested = false;
					localPlayerNotAuthenticated.dispatch();
					break;
				case InternalMessages.notAuthenticated :
					throw new Error( InternalMessages.notAuthenticatedError );
					break;
				case InternalMessages.scoreReported :
					localPlayerScoreReported.dispatch();
					break;
				case InternalMessages.scoreNotReported :
					localPlayerScoreReportFailed.dispatch();
					break;
				case InternalMessages.achievementReported :
					localPlayerAchievementReported.dispatch();
					break;
				case InternalMessages.achievementNotReported :
					localPlayerAchievementReportFailed.dispatch();
					break;
				case InternalMessages.loadFriendsComplete :
					var friends : Array = getReturnedPlayers( event.code );
					if( friends )
					{
						localPlayerFriendsLoadComplete.dispatch( friends );
					}
					else
					{
						localPlayerFriendsLoadFailed.dispatch();
					}
					break;
				case InternalMessages.loadFriendsFailed :
					localPlayerFriendsLoadFailed.dispatch();
					break;
				case InternalMessages.loadLocalPlayerScoreComplete :
					var score : GCLeaderboard = getReturnedLocalPlayerScore( event.code );
					if( score )
					{
						localPlayerScoreLoadComplete.dispatch( score );
					}
					else
					{
						localPlayerScoreLoadFailed.dispatch();
					}
					break;
				case InternalMessages.loadLocalPlayerScoreFailed :
					localPlayerScoreLoadFailed.dispatch();
					break;
				case InternalMessages.gameCenterViewRemoved :
					gameCenterViewRemoved.dispatch();
					break;
				case InternalMessages.loadLeaderboardComplete :
					var leaderboard : GCLeaderboard = getStoredLeaderboard( event.code );
					if( leaderboard )
					{
						leaderboardLoadComplete.dispatch( leaderboard );
					}
					else
					{
						leaderboardLoadFailed.dispatch();
					}
					break;
				case InternalMessages.loadLeaderboardFailed :
					leaderboardLoadFailed.dispatch();
					break;
			}
		}
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			if( !_isSupportedTested )
			{
				_isSupportedTested = true;
				init();
				_isSupported = extensionContext.call( NativeMethods.isSupported ) as Boolean;
			}
			return _isSupported;
		}
		
		private static function assertIsSupported() : void
		{
			if( !isSupported )
			{
				throw new Error( InternalMessages.notSupportedError );
			}
		}

		/**
		 * Authenticate the local player
		 */
		public static function authenticateLocalPlayer() : void
		{
			assertIsSupported();
			isAuthenticating = true;
			extensionContext.call( NativeMethods.authenticateLocalPlayer );
		}
		
		/**
		 * Is the local player authenticated
		 */
		public static function get isAuthenticated() : Boolean
		{
			return _isAuthenticated;
		}

		private static function assertIsAuthenticatedTested() : void
		{
			assertIsSupported();
			if( !_isAuthenticatedTested )
			{
				throw new Error( InternalMessages.authenticationNotAttempted );
			}
		}

		private static function assertIsAuthenticated() : void
		{
			assertIsAuthenticatedTested();
			if( !_isAuthenticated )
			{
				throw new Error( InternalMessages.notAuthenticatedError );
			}
		}
		
		/**
		 * Authenticate the local player
		 */
		public static function get localPlayer() : GCLocalPlayer
		{
			assertIsAuthenticatedTested();
			if( _isAuthenticated && !_localPlayerTested )
			{
				_localPlayer = extensionContext.call( NativeMethods.getLocalPlayer ) as GCLocalPlayer;
			}
			return _localPlayer;
		}
		
		/**
		 * Report a score to Game Center
		 */
		public static function reportScore( category : String, value : int ) : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.reportScore, category, value );
			}
		}
		
		/**
		 * Report a achievement to Game Center
		 */
		public static function reportAchievement( category : String, value : Number ) : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.reportAchievement, category, value );
			}
		}
		
		public static function showStandardLeaderboard( category : String = "", timeScope : int = -1 ) : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				if( category )
				{
					if( timeScope != -1 )
					{
						extensionContext.call( NativeMethods.showStandardLeaderboardWithCategoryAndTimescope, category, timeScope );
					}
					else
					{
						extensionContext.call( NativeMethods.showStandardLeaderboardWithCategory, category );
					}
				}
				else if( timeScope != -1 )
				{
					extensionContext.call( NativeMethods.showStandardLeaderboardWithTimescope, timeScope );
				}
				else
				{
					extensionContext.call( NativeMethods.showStandardLeaderboard );
				}
			}
		}
		
		public static function showStandardAchievements() : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.showStandardAchievements );
			}
		}
		
		public static function getLocalPlayerFriends() : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.getLocalPlayerFriends );
			}
		}
		
		public static function getLocalPlayerScore( category : String, playerScope : int = 0, timeScope : int = 2 ) : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.getLocalPlayerScore, category, playerScope, timeScope );
			}
		}
		
		public static function getLeaderboard( category : String, playerScope : int = 0, timeScope : int = 2, rangeStart : int = 1, rangeLength : int = 25 ) : void
		{
			assertIsAuthenticated();
			if( localPlayer )
			{
				extensionContext.call( NativeMethods.getLeaderboard, category, playerScope, timeScope, rangeStart, rangeLength );
			}
		}
		
		private static function getStoredLeaderboard( key : String ) : GCLeaderboard
		{
			return extensionContext.call( NativeMethods.getStoredLeaderboard, key ) as GCLeaderboard;
		}
		
		private static function getReturnedLocalPlayerScore( key : String ) : GCLeaderboard
		{
			return extensionContext.call( NativeMethods.getStoredLocalPlayerScore, key ) as GCLeaderboard;
		}
		
		private static function getReturnedPlayers( key : String ) : Array
		{
			return extensionContext.call( NativeMethods.getStoredPlayers, key ) as Array;
		}

		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			if ( extensionContext )
			{
				extensionContext.dispose();
				extensionContext = null;
			}
			localPlayerAuthenticated.removeAll();
			localPlayerNotAuthenticated.removeAll();
			localPlayerFriendsLoadComplete.removeAll();
			localPlayerFriendsLoadFailed.removeAll();
			leaderboardLoadComplete.removeAll();
			leaderboardLoadFailed.removeAll();
			localPlayerScoreLoadComplete.removeAll();
			localPlayerScoreLoadFailed.removeAll();
			localPlayerScoreReported.removeAll();
			localPlayerScoreReportFailed.removeAll();
			localPlayerAchievementReported.removeAll();
			localPlayerAchievementReportFailed.removeAll();
			gameCenterViewRemoved.removeAll();
			initialised = false;
		}
	}
}
