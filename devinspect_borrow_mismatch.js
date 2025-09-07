const { SuiClient, getFullnodeUrl, TransactionBlock } = require('@mysten/sui.js');

(async () => {
  const client = new SuiClient({ url: getFullnodeUrl('mainnet') });
  const PACKAGE = '0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca';
  const ORACLE_PKG = '0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f';

  const CLOCK_ID = '0x0000000000000000000000000000000000000000000000000000000000000006';
  const STORAGE_ID = '0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe';
  const ORACLE_ID = '0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef';
  const SUI_POOL_ID = '0x96df0fce3c471489f4debaaa762cf960b3d97820bd1f3f025ff8190730e958c5';

  const SENDER = '0x440b63f667b85a3f3555868ffafe0d4682ab063dc25209035356ab89047ff431';

  // We know from ReserveData[asset=0] that SUI's asset code is 0.
  const ASSET_SUI = 0;
  // Pick a mismatched asset code that exists but is not SUI, e.g., 4.
  const ASSET_MISMATCH = 4;

  const tx = new TransactionBlock();
  // Shared objects
  const clock = tx.sharedObjectRef({ objectId: CLOCK_ID, initialSharedVersion: 1, mutable: false });
  const storage = tx.sharedObjectRef({ objectId: STORAGE_ID, initialSharedVersion: 632444901, mutable: true });
  const oracle = tx.sharedObjectRef({ objectId: ORACLE_ID, initialSharedVersion: 632444900, mutable: false });
  const pool = tx.sharedObjectRef({ objectId: SUI_POOL_ID, initialSharedVersion: 632444897, mutable: true });

  // Call lending::borrow<T = 0x2::sui::SUI> with mismatched asset code
  tx.moveCall({
    target: `${PACKAGE}::lending::borrow`,
    typeArguments: ['0x2::sui::SUI'],
    arguments: [
      clock,
      oracle,
      storage,
      pool,
      tx.pure(ASSET_MISMATCH),
      tx.pure("1000000"), // amount u64
    ],
  });

  // devInspect with arbitrary sender (no gas object needed)
  const res = await client.devInspectTransactionBlock({ transactionBlock: tx, sender: SENDER });
  console.log(JSON.stringify(res, null, 2));
})();
