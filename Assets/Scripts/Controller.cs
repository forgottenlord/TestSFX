using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    [SerializeField]
    private Material material;
    void Start()
    {
        
    }

    void Update()
    {
        if (material != null)
        {
            material.SetVector("_TornadoPos", transform.position);
        }
    }
}
