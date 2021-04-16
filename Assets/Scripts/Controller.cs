using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    [SerializeField]
    private Material material;
    [SerializeField]
    private UnityEngine.UI.Image sensorMain;
    [SerializeField]
    private UnityEngine.UI.Image sensorAcc;
    private GameObject GoMain;
    private GameObject GoAcc;
    private float sensorSize;
    [SerializeField][Range(.01f, 3f)]
    private float tornadoSpeed = 0.01f;
    void Start()
    {
        if (sensorMain != null)
        {
            GoMain = sensorMain.gameObject;
            sensorSize = GoMain.GetComponent<RectTransform>().sizeDelta.x * .5f;
        }
        if (sensorAcc != null) GoAcc = sensorAcc.gameObject;
        /*transform.eulerAngles = new Vector3(-90,
            Quaternion.LookRotation(Camera.main.transform.position, transform.up).eulerAngles.y,
            0);*/
    }

    void Update()
    {
        if (material != null)
        {
            material.SetVector("_TornadoPos", transform.position);
        }
        if (sensorMain != null && sensorAcc != null)
        {
            if (Input.touchCount > 0)
            {
                Touch touch = Input.GetTouch(0);
                switch (touch.phase)
                {
                    case TouchPhase.Began:
                        {
                            OnBegin(Input.GetTouch(0).position);
                            break;
                        };
                    case TouchPhase.Moved:
                        {
                            OnHold(Input.GetTouch(0).position);
                            break;
                        };
                    case TouchPhase.Ended:
                        {
                            OnEnd(Input.GetTouch(0).position);
                            break;
                        };
                }
            }
            else
            {
                if (Input.GetMouseButtonDown(0))
                {
                    OnBegin(Input.mousePosition);
                }
                else
                if (Input.GetMouseButton(0))
                {
                    OnHold(Input.mousePosition);
                }
                else
                if (Input.GetMouseButtonUp(0))
                {
                    OnEnd(Input.mousePosition);
                }
            }
        }
    }
    public void OnBegin(Vector3 position)
    {
        GoMain.SetActive(true);
        GoAcc.SetActive(true);
        GoMain.transform.position = position;
        GoAcc.transform.localPosition = Vector3.zero;
    }
    public void OnHold(Vector3 position)
    {
        Vector3 diff = position - GoMain.transform.position;
        Debug.Log(diff.magnitude + "    " + sensorSize);
        if (diff.magnitude > sensorSize)
            diff = diff.normalized * sensorSize;
        GoAcc.transform.localPosition = diff;
        transform.position += (transform.up * diff.x + transform.right * diff.y) * tornadoSpeed * Time.deltaTime;
    }
    public void OnEnd(Vector3 position)
    {
        GoMain.SetActive(false);
        GoAcc.transform.localPosition = Vector3.zero;
        GoAcc.SetActive(false);
    }
}
