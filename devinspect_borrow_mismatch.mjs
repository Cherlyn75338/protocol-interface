import { SuiClient, getFullnodeUrl } from '@mysten/sui.js/client';
import { TransactionBlock } from '@mysten/sui.js/transactions';

const client = new SuiClient({ url: getFullnodeUrl('mainnet') });

const PACKAGE = '0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca';
const CLOCK_ID = '0x0000000000000000000000000000000000000000000000000000000000000006';
const STORAGE_ID = '0xbb4e2f4b6205c2e2a2db47aeb4f830796ec7c005f88537ee775986639bc442fe';
const ORACLE_ID = '0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef';
const SUI_POOL_ID = '0x96df0fce3c471489f4debaaa762cf960b3d97820bd1f3f025ff8190730e958c5';
const SENDER = '0x440b63f667b85a3f3555868ffafe0d4682ab063dc25209035356ab89047ff431';

const ASSET_SUI = 0;
const ASSET_MISMATCH = 4;

async function run(assetCode) {
  const tx = new TransactionBlock();
  const clock = tx.object(CLOCK_ID);
  const oracle = tx.object(ORACLE_ID);
  const storage = tx.object(STORAGE_ID);
  const pool = tx.object(SUI_POOL_ID);

  tx.moveCall({
    target: `${PACKAGE}::lending::borrow`,
    typeArguments: ['0x2::sui::SUI'],
    arguments: [clock, oracle, storage, pool, tx.pure.u8(assetCode), tx.pure.u64('1000000')],
  });

  const res = await client.devInspectTransactionBlock({ sender: SENDER, transactionBlock: tx });
  return res;
}

(async () => {
  const mismatch = await run(ASSET_MISMATCH);
  const match = await run(ASSET_SUI);
  console.log(JSON.stringify({ mismatch, match }, null, 2));
})();
