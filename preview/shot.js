const puppeteer = require('puppeteer');
const path = require('path');
const file = 'file://' + path.resolve('kirya_preview.html');

(async () => {
  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox','--disable-setuid-sandbox','--font-render-hinting=none']
  });

  async function shot(name, {width, height, lang, mobile=false, full=true}) {
    const page = await browser.newPage();
    await page.setViewport({width, height, deviceScaleFactor: mobile?2:1.5});
    await page.goto(file, {waitUntil:'networkidle0'});
    if (lang) {
      await page.select('#langSel', lang);
      await new Promise(r=>setTimeout(r,500));
    }
    await new Promise(r=>setTimeout(r,800)); // let fonts settle
    await page.screenshot({path:name, fullPage:full});
    console.log('saved', name);
    await page.close();
  }

  await shot('kirya_fr_desktop.png', {width:1440, height:900, lang:'fr'});
  await shot('kirya_ar_desktop.png', {width:1440, height:900, lang:'ar'});
  await shot('kirya_mobile_fr.png',  {width:390,  height:844, lang:'fr', mobile:true});

  await browser.close();
})().catch(e=>{console.error(e);process.exit(1)});
