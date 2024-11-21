import { useState } from 'react'
import reactLogo from './assets/react.svg'
import gcr from './assets/gcr.png'
import gar from './assets/gar.png'
import gcs from './assets/gcs.png'
import terraform_logo from './assets/terraform_logo.png'

import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div className='align_symbols'>
        <a href="" target="_blank">
          <img src={gcr} className="logo" alt="Vite logo" />
        </a>
        <a href="" target="_blank">
          <img src={gcs} className="logo" alt="Vite logo" />
        </a>
        <a href="" target="_blank">
          <img src={gar} className="logo" alt="Vite logo" />
        </a>
      </div>
      <div className='align_symbols'>
        <a href="" target="_blank">
          <img src={terraform_logo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h2>GCR + GAR + GCS + Terraform</h2>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          Click Me : {count}
        </button>

      </div>
      <p className="read-the-docs">
        Created In Order To Learn GCP Deployments
      </p>
      <p className="read-the-docs">
        made with ❤ <a target='_blank' href="https://github.com/moshdev2213">@moshdev2213</a>
      </p>
    </>
  )
}

export default App
