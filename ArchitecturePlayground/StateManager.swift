import Foundation

protocol StateManageable {
    
    /// 管理するStateタイプ
    associatedtype T: State
    
    /// Stateをセットするメソッド
    /// - 基本的にはこのメソッドからしかstateを変更できない
    func set(_ state: T)
    
    /// Stateをセットするメソッド
    /// - 基本的にはこのメソッドからしかstateを変更できない
    /// - callback内でpresenterを呼び出し、stateを渡す
    func set(_ state: T, useHandler: (T) -> Void)
    
    func use(_ useHandler: (T) -> Void)
    
    /// useCaseでstateを使いたい際に使うメソッド
    /// - stateを複製した値を渡す
    func duplicate() -> T
}

class StateManager<T: State>: StateManageable {
    
    typealias T = T
    
    init() {
        _state = T.initState()
    }
    
    /// stateの実態
    /// setメソッド以外で操作してはならない
    private var _state: T
    
    func set(_ state: T) {
        self._state = state
    }
    
    func set(_ state: T, useHandler: (T) -> Void) {
        self.set(state)
        useHandler(self.duplicate())
    }
    
    func use(_ useHandler: (T) -> Void) {
        useHandler(self.duplicate())
    }
    
    func duplicate() -> T {
        return self._state
    }
}
