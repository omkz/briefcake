// Images (jpg, jpeg, png, svg) are imported  here.
// They should be relative to this file, eg. "frontend/images/hero.jpg"
// You can use the following path helper in your views:
// `asset_pack_path('images/hero.jpg')` and `asset_pack_url('images/hero.jpg')` for absolute urls.

function importAll(r) {
  return r.keys().map(r);
}

const images = importAll(require.context("./", false, /.(png|jpe?g|svg)$/));

