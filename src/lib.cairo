#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increase_balance(ref self: TContractState, amount: felt252);
    fn decrease_balance(ref self: TContractState, amount: felt252);
    fn get_balance(self: @TContractState) -> felt252;
}

#[starknet::contract]
mod Counter {
    use super::ICounter;
use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    #[storage]
    struct Storage {
        balance: felt252,
    }

    #[abi(embed_v0)]
    impl CounterImpl of ICounter<ContractState> {
        fn increase_balance(ref self: ContractState, amount: felt252){
            assert(amount != 0, 'insufficient funds');
            let old_balance = self.balance.read();
            self.balance.write(old_balance + amount)
        }

        fn decrease_balance(ref self: ContractState, amount: felt252) {
            assert(amount != 0, 'Enter a number');
            let old_balance = self.balance.read();
            self.balance.write(old_balance - amount);
        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }
    }
}

