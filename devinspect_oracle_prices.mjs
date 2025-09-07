import { SuiClient, getFullnodeUrl } from '@mysten/sui.js/client';
import { TransactionBlock } from '@mysten/sui.js/transactions';
import { bcs } from '@mysten/sui.js/bcs';

const client = new SuiClient({ url: getFullnodeUrl('mainnet') });
const ORACLE_PKG = '0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f';
const CLOCK_ID = '0x0000000000000000000000000000000000000000000000000000000000000006';
const ORACLE_ID = '0x1568865ed9a0b5ec414220e8f79b3d04c77acc82358f6e5ae4635687392ffbef';
const SENDER = '0x440b63f667b85a3f3555868ffafe0d4682ab063dc25209035356ab89047ff431';

async function runOne(asset) {
  const tx = new TransactionBlock();
  const clock = tx.object(CLOCK_ID);
  const oracle = tx.object(ORACLE_ID);
  tx.moveCall({
    target: `${ORACLE_PKG}::oracle::get_token_price`,
    arguments: [clock, oracle, tx.pure.u8(asset)],
  });
  const res = await client.devInspectTransactionBlock({ sender: SENDER, transactionBlock: tx });
  const rv = res.results?.[0]?.returnValues?.[0];
  const rvs = res.results?.[0]?.returnValues || [];
  let tuple = null;
  if (rvs.length === 3) {
    const ok = bcs.bool().parse(Uint8Array.from(rvs[0][0]));
    const price = bcs.U256.parse(Uint8Array.from(rvs[1][0]));
    const decimal = bcs.u8().parse(Uint8Array.from(rvs[2][0]));
    tuple = { ok, price: price.toString(), decimal };
  }
  return { asset, result: tuple, error: res.effects?.status?.error || null };
}

(async () => {
  const assets = Array.from({ length: 32 }, (_, i) => i);
  const out = [];
  for (const a of assets) {
    try {
      out.push(await runOne(a));
    } catch (e) {
      out.push({ asset: a, error: String(e) });
    }
  }
  console.log(JSON.stringify(out, null, 2));
})();
