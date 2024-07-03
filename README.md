# Wordle Game

Wordle is a captivating word-guessing game that has become popular for its simplicity and addictive gameplay. The goal is to guess a hidden word in five attempts.

### 🏗️ Building

```sh
make
```

### ✅ Testing

Run all tests
```sh
make test
```

### init function

Receives and stores the Wordle program's address.

```rust
pub struct GameSessionInit {
    pub wordle_program_id: ActorId,
}
```

### handle function

```rust
#[derive(Debug, Clone, Encode, Decode, TypeInfo)]
pub enum GameSessionAction {
    StartGame,
    CheckWord {
        word: String,
    },
    CheckGameStatus {
        user: ActorId,
        session_id: MessageId,
    },
}
```

`StartGame`: Each user can start a game using this command, and they cannot start another game until the current game ends.

`CheckWord { .. }`: Using this command, you can guess the word, with a maximum of five attempts.

`CheckGameStatus { .. }`: This command is used by the program to check if the game has timed out but has not yet ended.

### state function

Returns the GameSessionState structure without parameter.

```rust
#[derive(Default, Debug, Clone, Encode, Decode, TypeInfo)]
pub enum SessionStatus {
    #[default]
    Init,
    WaitUserInput,
    WaitWordleStartReply,
    WaitWordleCheckWordReply,
    ReplyReceived(WordleEvent),
    GameOver(GameStatus),
}

#[derive(Default, Debug, Clone, Encode, Decode, TypeInfo)]
pub struct SessionInfo {
    pub session_id: MessageId,
    pub original_msg_id: MessageId,
    pub send_to_wordle_msg_id: MessageId,
    pub tries: u8,
    pub session_status: SessionStatus,
}

#[derive(Debug, Default, Clone, Encode, Decode, TypeInfo)]
pub struct GameSessionState {
    pub wordle_program_id: ActorId,
    pub game_sessions: Vec<(ActorId, SessionInfo)>,
}
```
